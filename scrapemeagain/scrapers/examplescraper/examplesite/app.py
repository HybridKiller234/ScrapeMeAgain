import sys

from flask import Flask, render_template, request


app = Flask(__name__)


@app.route("/posts/")
def post_list():
    page = int(request.args.get("page", 1))
    page_prev = page - 1
    page_next = page + 1
    page *= 10

    return render_template(
        "list.html",
        start=page - 9,
        stop=page,
        page_next=page_next,
        page_prev=page_prev,
    )


@app.route("/posts/<id>")
def post_detail(id):
    return render_template("item.html", id=id, back=request.referrer)


if __name__ == "__main__":
    try:
        host = sys.argv[1]
    except IndexError:
        host = "localhost"

    app.run(host=host, port=9090)
