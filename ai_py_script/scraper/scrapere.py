import time
import requests
from bs4 import BeautifulSoup
import pandas as pd

# Define the URL of the website to scrape
url = 'https://books.toscrape.com/'

# Send an HTTP request to the URL
try:
    response = requests.get(url)
    response.raise_for_status()  # Raise an HTTPError for bad responses
except requests.exceptions.RequestException as e:
    print(f"An error occurred: {e}")
    exit(1)

# Parse the HTML content
soup = BeautifulSoup(response.content, 'html.parser')

# Find the section containing the book list
book_list = soup.find_all('article', class_='product_pod')

# Extract data from each book
books = []
for book in book_list:
    try:
        title = book.h3.a['title']
        price = book.select_one('.price_color').text
        books.append({'title': title, 'price': price})
    except Exception as e:
        print(f"An error occurred while processing a book: {e}")

# Convert the data to a DataFrame
df = pd.DataFrame(books)

# Save the data to a CSV file
df.to_csv('books.csv', index=False)
print("Data has been saved to books.csv")

# Implement rate limiting
time.sleep(2)  # Wait for 2 seconds before making the next request