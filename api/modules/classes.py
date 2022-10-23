from pydantic import BaseModel
from typing import Optional

class Book(BaseModel):
    id: int
    name: str = "book_name"
    author: str = "author"
    description: str = "description"
    rate: Optional[int]
    