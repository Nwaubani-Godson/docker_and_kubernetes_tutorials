import os
from fastapi import FastAPI # type: ignore
import uvicorn # type: ignore

app = FastAPI() 

@app.get("/")
def home():
    app_name = os.getenv("APP_NAME")
    return {"message": f"Hello, This is {app_name}, feel free to explore!"}

if __name__ == "__main__":
    port = int(os.getenv("PORT", 8000))
    uvicorn.run(app, host="0.0.0.0", port=port)