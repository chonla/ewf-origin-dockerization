# docker build -t origin-migration-demo:latest -f migration-demo.Dockerfile .
# docker tag origin-migration-demo:latest chonla/origin-migration-demo:latest

FROM chonla/ewf-origin:latest

CMD ["yarn", "migrate:demo"]