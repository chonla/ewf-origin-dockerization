# docker build -t origin-simulator:latest -f simulator.Dockerfile .
# docker tag origin-simulator:latest chonla/origin-simulator:latest

FROM chonla/ewf-origin:latest

CMD ["yarn", "run:simulator"]