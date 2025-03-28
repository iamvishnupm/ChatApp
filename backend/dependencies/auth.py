from fastapi import Depends, Request
from fastapi.responses import JSONResponse 

from jose import jwt, JWTError
from sqlalchemy.orm import Session

from config import settings
from config.db import get_db
from models.users import User


def get_current_user( request : Request, db : Session = Depends(get_db) ):

    auth_header = request.headers.get("Authorization")

    if not auth_header or not auth_header.startswith("Bearer "):
        return JSONResponse(
            status_code=401, 
            content={"message" : "Token is missing or invalid"}
        )
    
    token = auth_header.split(" ")[1]

    try:
        payload = jwt.decode( token, settings.SECRET_KEY, algorithms=[settings.ALGORITHM])
        username = payload.get("sub")

        if not username:
            return JSONResponse(
                status_code=401,
                content = {"message" : "Invalid token data"}
            )
        
        db_user = db.query(User).filter( User.username == username ).first()

        if not db_user:
            return JSONResponse(
                status_code = 401,
                content = {"message" : "Invalid token data"}
            )

        return db_user
    
    except JWTError:
        return JSONResponse(
            status_code = 401, 
            content = {"message" : "Invalid or Expired Token" }
        )