FROM alpine:3.20

RUN apk add --no-cache python3 py3-pip py3-virtualenv

WORKDIR /app

COPY ./conf/ .

RUN python3 -m venv /app/venv
ENV PATH="/app/venv/bin:$PATH"

RUN pip3 install --no-cache-dir -r requirements.txt

EXPOSE 5000

ENTRYPOINT ["python3", "app.py"]
