package com.ipd.jmq.common.network.kafka.model;

/**
 * Created by zhangkepeng on 17-2-13.
 */
public class DelayedOperationKey {

    private String keyLabel;

    public DelayedOperationKey(Object ...args) {
        StringBuilder builder = new StringBuilder();
        if (args != null) {
            int size = args.length;
            for (int i = 0; i < size; i++) {
                if (i == size - 1) {
                    builder.append(args[i].toString());
                } else {
                    builder.append(args[i].toString() + "-");
                }
            }
        }
        keyLabel = builder.toString();
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        DelayedOperationKey that = (DelayedOperationKey) o;

        if (keyLabel != null ? !keyLabel.equals(that.keyLabel) : that.keyLabel != null) {
            return false;
        } else {
            return true;
        }

    }

    @Override
    public int hashCode() {
        int result = keyLabel != null ? keyLabel.hashCode() : 0;
        return result;
    }

    @Override
    public String toString() {
        return String.format("delayed operation key: " + keyLabel);
    }

    public String getKeyLabel() {
        return keyLabel;
    }
}
