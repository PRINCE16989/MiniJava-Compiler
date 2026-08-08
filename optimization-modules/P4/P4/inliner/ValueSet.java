package inliner;

import java.util.Collection;
import java.util.LinkedHashSet;

final class ValueSet {
    static final ValueSet EMPTY = new ValueSet(new LinkedHashSet<String>(), false);
    static final ValueSet UNKNOWN = new ValueSet(new LinkedHashSet<String>(), true);

    final LinkedHashSet<String> types;
    final boolean unknown;

    private ValueSet(LinkedHashSet<String> types, boolean unknown) {
        this.types = types;
        this.unknown = unknown;
    }

    static ValueSet of(String type) {
        LinkedHashSet<String> set = new LinkedHashSet<String>();
        if (type != null) {
            set.add(type);
        }
        return new ValueSet(set, false);
    }

    static ValueSet ofAll(Collection<String> types) {
        return new ValueSet(new LinkedHashSet<String>(types), false);
    }

    boolean isEmpty() {
        return !unknown && types.isEmpty();
    }

    boolean isUnknown() {
        return unknown;
    }

    ValueSet join(ValueSet other) {
        if (other == null || other.types.isEmpty() && !other.unknown) {
            return this;
        }
        if (unknown || other.unknown) {
            return UNKNOWN;
        }
        if (types.isEmpty()) {
            return other;
        }
        LinkedHashSet<String> joined = new LinkedHashSet<String>(types);
        joined.addAll(other.types);
        return new ValueSet(joined, false);
    }

    String key() {
        if (unknown) {
            return "?";
        }
        StringBuilder builder = new StringBuilder();
        boolean first = true;
        for (String type : types) {
            if (!first) {
                builder.append('|');
            }
            builder.append(type);
            first = false;
        }
        return builder.toString();
    }

    @Override
    public boolean equals(Object obj) {
        if (!(obj instanceof ValueSet)) {
            return false;
        }
        ValueSet other = (ValueSet) obj;
        return unknown == other.unknown && types.equals(other.types);
    }

    @Override
    public int hashCode() {
        return 31 * types.hashCode() + (unknown ? 1 : 0);
    }

    @Override
    public String toString() {
        return unknown ? "?" : types.toString();
    }
}
