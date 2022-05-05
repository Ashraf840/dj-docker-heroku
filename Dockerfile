# Define OS for utilizing our App
FROM python:3.8-slim-buster
# Define default WD Of this Docker Image
WORKDIR /app

# Create & activate virtual env
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Copy the "requirements.txt" file inside the Docker's WD.
COPY requirements.txt .

# Upgrade pip & install other repos
RUN pip install --upgrade pip \
    && pip install -r requirements.txt

# Copy other files & directories inside the Docker's WD
COPY . .

# Development Server CMD
# CMD ["python", "manage.py", "runserver", "0.0.0.0:8080"]

# Production Server CMD; the Dj app will run on host 0.0.0.0 & port 8080 of the container.
# CMD ["gunicorn", "--bind", ":8080", "--workers", "3", "core.wsgi:application"]

# Production Server CMD - Heroku, dynamic port-variable defined by Heroku.
CMD gunicorn core.wsgi:application --bind 0.0.0.0:$PORT

# Expose this app to port 8080 of this container
EXPOSE 8080