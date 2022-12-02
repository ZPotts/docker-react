# A two step dockerfile
# Also, notice TAGGING in "as". to tag the 
FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .

# 'build' dir will be built in WORKDIR, or: 
# /app/build
RUN npm run build

# The From-statement signifies the end of one block and start of the next.
# So you don't need to do anything else to define the blocs
FROM nginx

# we are copying from the 'builder' phase
# and it was tagged builder at the start
COPY --from=builder /app/build /usr/share/nginx/html

