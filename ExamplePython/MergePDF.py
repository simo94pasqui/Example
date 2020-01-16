# Command line:
# - python MergePDF.py <namefile0>.pdf <namefile1>.pdf <namefile2>.pdf ...

from PyPDF2 import PdfFileMerger
import sys

pdfs = []

if len(sys.argv) >= 2:
    for i_pdf in sys.argv[1:]:
        pdfs.append(i_pdf)

merger = PdfFileMerger()

for pdf in pdfs:
    merger.append(pdf)

merger.write("merge.pdf")
merger.close()
print("Merge PDF OK!")