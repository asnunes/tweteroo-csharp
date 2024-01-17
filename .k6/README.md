Make sure you generated the csv data before running tests

1. Install dependencies

```bash
pip install python-dotenv psycopg2-binary uuid
```

2. Create a `.env` file inside this folder from the `.env.example` file

```bash
cp .env.example .env
```

3. Run the seed script. **ATTENTION**: All data will be deleted from the database before seeding.

```bash
python ./seed/users.py
```
