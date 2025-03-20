from sqlalchemy.orm import Session
from models.users import User 
from schemas.users import UserCreate 


def create_user( user : UserCreate, db : Session ):
    db_user = User( username=user.username, email=user.email, password=user.password )
    
    db.add(db_user)
    db.commit()
    db.refresh(db_user)

    return db_user