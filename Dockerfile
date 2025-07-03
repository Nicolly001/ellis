FROM python:3.13.5-alpine3.22

# 2. Set the working directory in the container
WORKDIR /app

# 3. Copy the dependencies file to the working directory
# This is done first to leverage Docker's layer caching.
# The layer with installed dependencies will be reused if requirements.txt doesn't change.
COPY requirements.txt .

# 4. Install any needed packages specified in requirements.txt
# --no-cache-dir reduces image size
# --upgrade pip ensures we have the latest version
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copy the rest of the application's code to the working directory
COPY . .

# 6. Expose the port the app runs on
EXPOSE 8000

# 7. Define the command to run the app
# Use 0.0.0.0 to make the app accessible from outside the container
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
