"""One source for reader-facing day, session and slide headings."""
from pathlib import Path
import json,re
CATALOG=json.loads((Path(__file__).with_suffix('.json')).read_text(encoding='utf-8'))
def apply_titles(text,name):
 stem=Path(name).stem
 entry=next(s for s in CATALOG['sessions'] if s['deck']==stem or s['deck'].removesuffix('_live')==stem)
 text=re.sub(r'^title: .*$',lambda m:'title: '+json.dumps(entry['title']),text,count=1,flags=re.M)
 subtitle=f"Day {entry['day']} | Session {entry['session']}: {entry['subtitle']}"
 text=re.sub(r'^subtitle: .*$',lambda m:'subtitle: '+json.dumps(subtitle),text,count=1,flags=re.M)
 headings=iter(entry['headings']);count=0
 def replace(match):
  nonlocal count
  count+=1
  return '## '+next(headings)+' '+match[1]
 text=re.sub(r'^## .*? (\{.*?\})$',replace,text,flags=re.M)
 assert count==len(entry['headings']),(name,count)
 return text
