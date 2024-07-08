FROM alpine:latest

RUN apk update && apk add nginx python3 py3-pip 
RUN python3 -m venv /venv
RUN source /venv/bin/activate

WORKDIR /app

COPY requirements.txt /app/requirements.txt
RUN /venv/bin/pip install --no-cache-dir -r /app/requirements.txt

COPY app.py /app/

RUN /venv/bin/pip install gunicorn

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD nginx && /venv/bin/gunicorn --bind 0.0.0.0:8000 app:app