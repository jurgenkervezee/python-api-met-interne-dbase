from fastapi import FastAPI, HTTPException
import uvicorn
from pydantic import BaseModel, Field
from setup import setup_database
import sqlite3

app = FastAPI()
class Book(BaseModel):
    author: str = Field(examples=["J.K. Rowling"])
    country: str = Field(examples=["Scotland"])
    imageLink: str = Field(examples=["images/deathly_hallows.jpg"])
    link: str = Field(examples=["https://en.wikipedia.org/wiki/Harry_Potter_and_the_Deathly_Hallows"])
    language: str = Field(examples=["English"])
    pages: str | int = Field(examples=["784", 784])
    title: str = Field(examples=["Harry Potter and the Deathly Hallows"])
    year: str | int = Field(examples=["2007", 2007])

c, con = setup_database("api.db")

@app.get("/books/{book_id}", response_model=dict, tags=["Read"])
def get_single_book(book_id: int):
    c.execute("""
            SELECT id, author, country, imageLink, language, link, pages, title, year
            FROM books WHERE id=?""", (book_id,))
    row = c.fetchone()
    if row is None:
        raise HTTPException(status_code=404, detail="Book not found")
    return {"id":row[0],
             "author":row[1],
             "country":row[2],
             "imageLink":row[3],
             "language":row[4],
             "link":row[5],
             "pages":row[6],
             "title":row[7],
             "year":row[8]}

@app.post("/books/", response_model=Book, tags=["Create"])
def create_book(book: Book):
    try:
        c.execute("""
        	INSERT INTO books (author, country, imageLink, language, link, pages, title, year)
        	VALUES (?, ?, ?, ?, ?, ?, ?, ?)""",
         	(book.author, book.country, book.imageLink, book.language, book.link, book.pages, book.title, book.year)
        )
        con.commit()
        return book
    except sqlite3.IntegrityError as e:
        raise HTTPException(status_code=202, detail="Book already exists. Not created.") from e

@app.get("/books/all/", response_model=list[dict], tags=["Read"])
def get_all_books():
    c.execute("""
              SELECT id, author, country, imageLink, language, link, pages, title, year
              FROM books
              ORDER BY RANDOM()""")
    rows = c.fetchall()
    return [{"id":row[0],
             "author":row[1],
             "country":row[2],
             "imageLink":row[3],
             "language":row[4],
             "link":row[5],
             "pages":row[6],
             "title":row[7],
             "year":row[8]} for row in rows]

@app.get("/books/total/", response_model=dict, tags=["Read"])
def total_books():
    c.execute("""
              SELECT id
              FROM books""")
    rows = c.fetchall()
    return {"total_books": len(rows)+1}


@app.put("/books/{book_id}", response_model=dict, tags=["Update"])
def update_book(book_id: int, book: Book):
    try:
        c.execute("""
            UPDATE books
            SET author=?, country=?, imageLink=?, language=?, link=?, pages=?, title=?, year=?
            WHERE id=?""",
            (book.author, book.country, book.imageLink, book.language, book.link, book.pages, book.title, book.year, book_id)
        )
        con.commit()
    except sqlite3.IntegrityError as e:
        raise HTTPException(status_code=202, detail="Book is no longer unique.") from e
    return {"id": book_id, **book.model_dump()}

@app.delete("/books/{book_id}", tags=["Delete"])
def delete_book(book_id: int):
    print(get_single_book(book_id))
    c.execute("DELETE FROM books WHERE id=?", (book_id,))
    con.commit()
    return {"detail": f"Book with ID {book_id} deleted successfully"}

@app.post("/direct_query/{query}", response_model=list, include_in_schema=True, tags=["Part 2"])
def query_db(query: str):
    c.execute(query)
    rows = c.fetchall()
    column_names = [column[0] for column in c.description]
    return [dict(zip(column_names, row)) for row in rows]

if __name__ == "__main__":
    uvicorn.run(app, host='0.0.0.0', port=8000)
