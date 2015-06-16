import os
import os
import glob
from collections import Counter

os.system("""rm out/*""")

for i in range(100):
    os.system("""gprolog --init-goal "[jouer],randomize,jouer_ia_vs_ia,halt" > out/"""+str(i))

count = Counter()

L = 0
for filename in glob.glob('out/*'):
    content = [x.strip() for x in open(filename).readlines() if len(x.strip()) > 0]
    try:
        count[content[-1].split(':',2)[1]] += 1
        L += 1
    except:
        pass

for x,n in count.most_common():
    print(x,":{:.1f}%".format(n/L*100))
print('L',L)