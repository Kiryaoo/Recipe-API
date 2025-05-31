FROM python:3.9-alpine
LABEL maintainer="recipe.com"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

RUN python -m venv /py
RUN /py/bin/pip install --upgrade pip
RUN /py/bin/pip install -r /tmp/requirements.txt  # <--- Слідкуйте, чи помилка буде саме тут
RUN rm -rf /tmp/requirements.txt
RUN adduser \
        -D \
        -S \
        -h /home/django-user \
        --no-create-home \
        django-user
ENV PATH="/py/bin:$PATH"

USER django-user