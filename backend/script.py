# import requests
# import json
# import firebase_admin
# from firebase_admin import credentials, firestore

# # Initialize Firebase Admin SDK (Replace 'path/to/serviceAccount.json' with your Firebase Admin SDK JSON file)
# cred = credentials.Certificate("E:/bhi/bhi/backend/serviceAccountKey.json")
# firebase_admin.initialize_app(cred)

# # Firestore instance
# db = firestore.client()

# def fetch_cover(book_titles):
#     """
#     Fetch book cover URLs using OpenRouter API.
#     """
#     comma_separated = ", ".join(book_titles)
#     response = requests.post(
#         url="https://openrouter.ai/api/v1/chat/completions",
#         headers={
#             "Authorization": "Bearer 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"
#         },
#         data=json.dumps({
#             "model": "deepseek/deepseek-r1",  # Optional
#             "messages": [
#                 {
#                     "role": "user",
# "content": f"Fetch book cover images for these books: {comma_separated}. Respond ONLY with a JSON array formatted like this: [{'title': 'cover_url'}]."
#                 }
#             ]
#         })
#     )

#     # Debugging: Print raw API response
#     print(f"✅ API Response Status: {response.status_code}")
#     print(f"📜 Raw API Response: {response.text}")  # <-- Add this line

#     if response.status_code == 200:
#         try:
#             return json.loads(response.json()["choices"][0]["message"]["content"])
#         except json.JSONDecodeError as e:
#             print(f"❌ JSON Decode Error: {e}")
#             print(f"📜 API Response Content: {response.text}")  # <-- Add this line
#             return None
#     else:
#         print("❌ Error fetching covers:", response.text)
#         return None


# def update_firestore_with_covers():
#     """
#     Fetch missing book covers and update Firestore.
#     """
#     books_ref = db.collection("BOOKS")
#     books = books_ref.stream()

#     missing_books = []
#     book_ids = {}

#     for book in books:
#         book_data = book.to_dict()
#         if not book_data.get("image"):  # Check if image field is empty
#             title = book_data.get("title", "Unknown")
#             missing_books.append(title)
#             book_ids[title] = book.id

#     if missing_books:
#         print("Fetching covers for missing books:", missing_books)
#         cover_data = fetch_cover(missing_books)

#         if cover_data:
#             for book_entry in cover_data:
#                 for title, cover_url in book_entry.items():
#                     if title in book_ids:
#                         book_id = book_ids[title]
#                         db.collection("BOOKS").document(book_id).update({"image": cover_url})
#                         print(f"Updated Firestore: {title} -> {cover_url}")

# if __name__ == "__main__":
#     update_firestore_with_covers()
