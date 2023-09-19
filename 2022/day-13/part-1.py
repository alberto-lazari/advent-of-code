def compare(left, right):
    if left == []:
        if right == []: return 0
        return -1
    if right == []: return 1

    l = left.pop(0)
    r = right.pop(0)
    if isinstance(l, int) and isinstance(r, int):
        if l < r: return -1
        if l > r: return 1
    else:
        if isinstance(l, int): l = [l]
        if isinstance(r, int): r = [r]

        result = compare(l, r)
        if result != 0: return result

    return compare(left, right)

sum = 0
for n, pair in enumerate(open('/dev/stdin').read().rstrip().split('\n\n')):
    [left, right] = map(eval, pair.split('\n'))

    result = compare(left, right)
    # print(n + 1, result)
    if result <= 0: sum += n + 1

print(sum)
