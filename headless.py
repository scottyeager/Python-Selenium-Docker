from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By

options = webdriver.ChromeOptions()
options.add_argument("--enable-javascript")
options.add_argument("--no-sandbox")
options.add_argument("--headless=new")

driver = webdriver.Chrome(options=options)
