from sqlalchemy.orm import Session 
from fastapi import APIRouter, Depends
from fastapi.responses import JSONResponse 

from  models.users import User
from schemas.users import UserCreate, UserLogin

from config.db import get_db
from users.functions import create_user

router = APIRouter( prefix="/users", tags=["users"])

@router.post('/register')
def register_user( user: UserCreate, db: Session = Depends(get_db) ):

    existing_user = (
        db.query(User)
        .filter( (User.username == user.username) | (User.email == user.email) )
        .first()
    )

    if existing_user:
        return JSONResponse(status_code=400, content="User already exist!")

    db_user = create_user( user, db )

    return "Register success"


@router.post("/login")
def login_user( user : UserLogin, db : Session = Depends(get_db) ):

    db_user = db.query(User).filter( User.username == user.username ).first()

    if not db_user:
        return JSONResponse( status_code=400, content="User not exist!")
    if db_user.password != user.password:
        return JSONResponse(status_code=400, content="Incorrect Password")
    
    return "Login Success"