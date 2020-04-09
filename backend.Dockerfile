# docker build -t origin-backend-app:latest -f backend.Dockerfile .
# docker tag origin-backend-app:latest chonla/origin-backend-app:latest

FROM chonla/ewf-origin:latest

CMD ["yarn", "run:backend"]