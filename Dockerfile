FROM fukamachi/sbcl:latest-alpine as build

COPY . /app

RUN sbcl --eval '(load "/app/99-bottles.asd")' \
         --eval '(ql:quickload :99-bottles)' \
         --eval "(sb-ext:save-lisp-and-die \"/app/99-bottles\" :executable t :toplevel '99-bottles:main)"

FROM fukamachi/sbcl:latest-alpine as dist

COPY --from=build /app /app

ENTRYPOINT ["/app/99-bottles"]

EXPOSE 8080
