FROM python:3.11.4-slim-bookworm

COPY --from=ghcr.io/astral-sh/uv:0.11.19 /uv /bin/uv

# define work directory
WORKDIR /app/
COPY . /app

# install pinned backend environments committed to the repository
RUN find /app -type f -exec sed -i 's/\r$//' {} +
RUN apt update && apt install -y git
RUN cd backend && ./setup-sigma-plugins.sh

# launch front- and backend
EXPOSE 8000
ENTRYPOINT ["./entrypoint.sh"]
