FROM ubuntu:22.04
RUN apt-get update && apt install -y --no-install-recommends \
                                    python3-pip \
                                    libglib2.0-0 \
                                    libnss3 \
                                    libxcb1 \
                                    libdbus-1-3 \
                                    libatk1.0-0 \
                                    libatk-bridge2.0-0 \
                                    libcups2 \
                                    libdrm2 \
                                    libxkbcommon0 \
                                    libxcomposite1 \
                                    libxdamage1 \
                                    libxfixes3 \
                                    libxrandr2 \
                                    libgbm1 \
                                    libpango-1.0-0 \
                                    libcairo2 \
                                    libasound2 \
    && rm -rf /var/lib/apt/lists/*

RUN pip install selenium

RUN ln -s /usr/bin/python3 /usr/bin/python

COPY headless.py /root/headless.py
