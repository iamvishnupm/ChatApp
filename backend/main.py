import init 

init.setup_project_root()

# ==================================


from config.db import Base, engine
from fastapi import FastAPI 
from routes.auth import user

Base.metadata.create_all(bind=engine)

app = FastAPI()
app.include_router(user.router)

@app.get('/')
def root():
    return "Root Page"
