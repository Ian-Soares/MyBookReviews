from fastapi import FastAPI
from pymongo import MongoClient
import os
from modules.classes import Book
from fastapi.middleware.cors import CORSMiddleware

db_passwd = os.environ["MONGO_PASSWD"]
db_user = os.environ["MONGO_USER"]
connection_string = f"mongodb+srv://{db_user}:{db_passwd}@studycluster.djsfy.mongodb.net/?ssl=true&ssl_cert_reqs=CERT_NONE"

cluster = MongoClient(connection_string)

db = cluster["bookpedia"]
collection = db["books"]

app = FastAPI(title="MyBooksReview API")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
    )

@app.get('/api/get_books/')
def get_books():
    list_of_books = []
    results = collection.find({})
    for result in results:
        list_of_books.append(result)
    return list_of_books


@app.post('/api/new_book/')
def new_book(book: Book):
    book_json = {
        "_id":f"{book.id}",
        "name": f"{book.name}",
        "author": f"{book.author}",
        "description": f"{book.description}",
        "rate": book.rate
    }
    collection.insert_one(book_json)
    return {"Status":"Book added!"}


@app.put('/api/edit_book/{book_id}/')
def edit_book(book_id, book: Book):
    collection.update_many({"_id":f"{book_id}"}, {"$set":{
        "name":f"{book.name}",
        "author":f"{book.author}",
        "description":f"{book.description}",
        "rate":book.rate
    }})
    return {"Status":"Book updated!"}


@app.delete('/api/delete_book/{book_id}/')
def delete_book(book_id):
    collection.delete_one({"_id":f"{book_id}"})
    return {"Status":"Book deleted!"}

