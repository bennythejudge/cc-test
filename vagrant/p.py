'''
# Read input from stdin and provide input before running code

name = raw_input()
print 'Hi, %s.' % name
'''
grid = []
counter=0

n = int(raw_input())

for i in xrange(0,n):
        a = raw_input().split()
        #print a
        grid.append([])
        #print i
        for b in a:
            #print "appending {} at {}".format(b,i)
            grid[i].append(int(b))

#print "grid: {}".format(grid)

print "rows: {} cols: {}".format(len(grid), len(grid[len(grid)-1]))


for i in xrange(0,len(grid)):
    #print i
    for c in xrange(0,len(grid[i])):
        #print grid[i][c]
        top=0
        bottom=0
        left=0
        right=0
        if i-1>=0: # there is a top there is also a c
            top=grid[i-1][c]
        if i+1<=len(grid)-1:  # there is bottom line
            #print "bottom: {}".format(grid[i+1][c])
            bottom=grid[i+1][c]
        if c-1>=0: # there is a column on the left
            left=grid[i][c-1]
        if c+1<=len(grid[i])-1: # there is a column on the right
            right=grid[i][c+1]
        print "top {} bottom {} left {} right {}".format(top,bottom,left,right)
        sum = top + left + right + bottom
        if sum%2 != 0:
            counter += 1
            print counter
print counter
