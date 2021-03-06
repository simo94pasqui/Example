# Command line:
# - python ConvertToPDF.py <namefile>/.jpg/.png <namefile_pdf (optional)>

import sys
from PIL import Image
from fpdf import FPDF

if len(sys.argv) >= 2:
    filename = sys.argv[1]
    filename_list = filename.split('.')
    if len(filename_list) < 2:
        print("PDF Extension Error!")
        sys.exit()

    if len(sys.argv) == 2:
        pdf = filename_list[0] + ".pdf"
    else:
        pdf = sys.argv[2]
        pdf_list = pdf.split('.')
        if len(pdf_list) < 2:
            pdf += ".pdf"

    if filename_list[1] == "jpg" or filename_list[1] == "jpeg" or filename_list[1] == "JPG" or filename_list[1] == "JPEG":
        Image.open(filename).save(pdf, save_all=True)
        print("JPG to PDF Create!")
    elif filename_list[1] == "png" or filename_list[1] == "PNG":
        Image.open(filename).convert('RGB').save(pdf, save_all=True)
        print("PNG to PDF Create!")
    else:
        Image.open(filename).save(pdf, "PDF", resolution=100.0)
        print("Image to PDF Create!")
else:
    print("PDF Error!")
    sys.exit()