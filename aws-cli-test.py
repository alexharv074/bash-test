import awscli.clidriver
from cStringIO import StringIO
import sys

driver = awscli.clidriver.create_clidriver()

old_stdout = sys.stdout
sys.stdout = mystdout = StringIO()

driver.main(['ec2','describe-instances'])

sys.stdout = old_stdout

myvar = mystdout.getvalue()
