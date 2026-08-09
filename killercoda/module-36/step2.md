# Step 2 — Design on paper, then write the API

**Design first** (the Learner's Law — the paper design is the contract). Our `/items` resource:

| Method + path | Does | Success | Failure |
|---|---|---|---|
| `GET /items` | list items | `200` | — |
| `POST /items` | create an item | **`201`** | **`422`** on bad body |
| `GET /items/{id}` | read one | `200` | **`404`** if missing |
| `DELETE /items/{id}` | remove one (**token-protected**) | `200` | **`401`** no token · `404` missing |

Resources are **nouns** (`/items`), methods carry the **verb**. Now write it:

```bash
mkdir -p ~/api-lab && cat > ~/api-lab/main.py <<'PY'
from fastapi import FastAPI, HTTPException, Depends, Header, status
from pydantic import BaseModel, Field

app = FastAPI(title="Items API", version="1.0.0")
API_TOKEN = "secret-token"
_items, _next = {}, {"id": 1}

class ItemIn(BaseModel):            # the request contract (validated)
    name: str = Field(min_length=1)
    price: float = Field(gt=0)      # must be > 0 — bad input -> 422

class ItemOut(ItemIn):
    id: int

def require_token(authorization: str = Header(default="")):
    if authorization != f"Bearer {API_TOKEN}":     # authn: who are you?
        raise HTTPException(status.HTTP_401_UNAUTHORIZED, "missing or invalid token")

@app.get("/items")
def list_items():
    return list(_items.values())

@app.post("/items", status_code=201, response_model=ItemOut)
def create_item(item: ItemIn):
    rec = {"id": _next["id"], **item.model_dump()}
    _items[_next["id"]] = rec
    _next["id"] += 1
    return rec

@app.get("/items/{item_id}", response_model=ItemOut)
def get_item(item_id: int):
    if item_id not in _items:
        raise HTTPException(404, "item not found")   # correct code, not 200
    return _items[item_id]

@app.delete("/items/{item_id}")
def delete_item(item_id: int, _=Depends(require_token)):   # protected route
    if item_id not in _items:
        raise HTTPException(404, "item not found")
    return {"deleted": _items.pop(item_id)["id"]}
PY
```{{exec}}

Confirm the file is valid Python:

```bash
python3 -c "import ast; ast.parse(open('$HOME/api-lab/main.py').read()); print('main.py parses OK')"
```{{exec}}

Read it top to bottom: the **Pydantic** `ItemIn` model is the contract; the method + `status_code` set
the verb and success code; `HTTPException` sets the correct failure code; `Depends(require_token)` makes
one route require a token. Nothing here trusts the client.
