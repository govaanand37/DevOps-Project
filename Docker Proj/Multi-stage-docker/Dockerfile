# Stage one to build image
FROM ubuntu AS build

WORKDIR /app

COPY requirements.txt /app
COPY devops /app

RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    pip install -r requirements.txt
    

# Stage two to optimise and run the application [with 10x smaller container]
FROM python:3.10-alpine

COPY --from=build /app /app

RUN cd app

ENTRYPOINT ["python3"]
CMD ["manage.py", "runserver", "0.0.0.0:8000"]