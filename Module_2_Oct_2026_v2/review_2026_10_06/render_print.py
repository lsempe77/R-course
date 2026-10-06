"""Native Word fallback: packaged renderer has no LibreOffice on this machine."""
from pathlib import Path
import sys
import win32com.client
import fitz
from PIL import Image,ImageDraw
root=Path(__file__).resolve().parents[1]
out=root/'review_2026_10_06/qa'/sys.argv[1];out.mkdir(parents=True,exist_ok=True)
files=[root/p for p in sys.argv[2:]]
app=win32com.client.DispatchEx('Word.Application');app.Visible=False;app.DisplayAlerts=0;app.AutomationSecurity=3
images=[]
try:
    for p in files:
        doc=app.Documents.Open(str(p.resolve()),ReadOnly=True,AddToRecentFiles=False,Visible=False,OpenAndRepair=True)
        pdf=out/(p.stem+'.pdf');doc.ExportAsFixedFormat(str(pdf),17);doc.Close(False)
        d=fitz.open(pdf);print(p.name,len(d),'pages',flush=True)
        for i,page in enumerate(d):
            target=out/f'{p.stem}_{i+1:02}.png';page.get_pixmap(matrix=fitz.Matrix(1.3,1.3)).save(target);images.append(target)
finally:app.Quit()
for n in range(0,len(images),4):
    canvas=Image.new('RGB',(1600,2300),'#dddddd')
    for j,f in enumerate(images[n:n+4]):
        im=Image.open(f);im.thumbnail((780,1100));x=j%2*800;y=j//2*1150
        canvas.paste(im,(x,y+30));ImageDraw.Draw(canvas).text((x+10,y+5),f.stem,fill='black')
    canvas.save(out/f'montage{n//4}.jpg')
