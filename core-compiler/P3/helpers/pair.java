package helpers;

public class pair<F, S> {
    public F first;
    public S second;

    public pair(F first, S second) {
        this.first = first;
        this.second = second;
    }

    public F getFirst() {
        return first;
    }

    public S getSecond() {
        return second;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof pair<?, ?>)) return false;
        pair<?, ?> p = (pair<?, ?>) o;
        return java.util.Objects.equals(first, p.first) &&
               java.util.Objects.equals(second, p.second);
    }

    public String toString() {
        return "(" + first + ", " + second + ")";
    }
}
