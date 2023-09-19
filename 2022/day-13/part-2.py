def compare(left, right):
    if left == []:
        if right == []: return 0
        return -1
    if right == []: return 1

    l = left[0]
    r = right[0]
    if isinstance(l, int) and isinstance(r, int):
        if l < r: return -1
        if l > r: return 1
    else:
        if isinstance(l, int): l = [l]
        if isinstance(r, int): r = [r]

        result = compare(l, r)
        if result != 0: return result

    return compare(left[1:], right[1:])

def merge_sort(l):
    def merge(left, right):
        result = []
        while len(left) * len(right) > 0:
            result.append(left.pop(0) if compare(left[0], right[0]) < 0 else right.pop(0))
        result = result + left + right
        return result

    size = len(l)
    if not size > 1: return l

    half_size = int(size / 2)
    left = l[:half_size]
    right = l[half_size:]
    return merge(merge_sort(left), merge_sort(right))

packets=[]
for n, pair in enumerate(open('/dev/stdin').read().rstrip().split('\n\n')):
    [left, right] = map(eval, pair.split('\n'))
    packets.append(left)
    packets.append(right)

# Append the dividers
dividers = [ [[2]], [[6]] ]
for divider in dividers:
    packets.append(divider)

# Sort the packets
merged = merge_sort(packets)
product = 1
for divider in dividers:
    index = merged.index(divider) + 1
    product *= index

print(product)
