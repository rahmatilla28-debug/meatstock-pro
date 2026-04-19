from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.database import Base, engine

Base.metadata.create_all(bind=engine)

app = FastAPI(
    title="MeatStock Pro",
    version="1.0.0",
    docs_url="/api/docs"
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:3000", "file://"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

try:
    from app.routers import auth, stock, production
    from app.routers import invoices, reports, suppliers
    app.include_router(auth.router)
    app.include_router(suppliers.router)
    app.include_router(stock.router)
    app.include_router(production.router)
    app.include_router(invoices.router)
    app.include_router(reports.router)
except Exception as e:
    print(f"Router error: {e}")

@app.get("/")
def root():
    return {"app": "MeatStock Pro", "status": "running"}

@app.get("/health")
def health():
    return {"status": "healthy"}