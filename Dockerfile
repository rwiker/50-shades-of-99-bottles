FROM fukamachi/sbcl:latest-alpine as build

COPY . .

RUN sbcl --eval '(load "99-bottles.asd")' \
    	 --eval '(ql:quickload :99-bottles)' \
    	 --eval "(sb-ext:save-lisp-and-die \"/usr/local/bin/99-bottles\" :executable t :toplevel '99-bottles:main)"

FROM fukamachi/sbcl:latest-alpine as dist

COPY --from=build /usr/local/bin/99-bottles /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/99-bottles"]

EXPOSE 8080