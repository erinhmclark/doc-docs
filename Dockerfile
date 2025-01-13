FROM python:3.13-slim AS base

ENV RUNNING_IN_DOCKER=1 \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONFAULTHANDLER=1 \
    PATH="/root/.local/bin:$PATH"


# Poetry and runtime
FROM base AS runtime

ENV POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_IN_PROJECT=1 \
    POETRY_VIRTUALENVS_CREATE=1

RUN pip install --upgrade pip && \
    pip install "poetry>=2.0.0,<3.0.0"

WORKDIR /app

COPY pyproject.toml poetry.lock README.md ./
COPY ./src/ .
RUN poetry install --only main --no-cache


# Update PATH to include virtual environment binaries
# Allowing entry point to run the application directly with Python
ENV VIRTUAL_ENV=/app/.venv \
    PATH="/app/.venv/bin:$PATH"

ENTRYPOINT ["python3", "-m", "doc_docs"]
