import os
from dotenv import load_dotenv 

from fastapi import FastAPI

from sqlalchemy import create_engine, MetaData
from sqlalchemy.orm import declarative_base, sessionmaker

# ==========================================================

load_dotenv()

DB_URL = os.getenv("DB_URL")

# ==========================================================

engine = create_engine(DB_URL)
metadata = MetaData()
Base = declarative_base()

db_session = sessionmaker(autoflush=False, autocommit=False, bind=engine)

# ==========================================================

def get_db():
    db = db_session()
    
    try:
        yield db
    
    except:
        pass
    
    finally:
        db.close()

# ==========================================================