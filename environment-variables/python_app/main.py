from fastapi import FastAPI # type: ignore

app = FastAPI()

@app.get("/")
def home():
    return {"message": "Hello, This is my python application!"}

if __name__ == "__main__":
    import uvicorn # type: ignore
    uvicorn.run(app, host="0.0.0.0", port=5000)
