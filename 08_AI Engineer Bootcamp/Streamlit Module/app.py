import streamlit as st

st.title('Hello World!')

with st.chat_message("AI"):
    st.write("Hello there!")

prompt = st.chat_input("Type your message", max_chars=50)
if prompt:
    st.write(f'User message: {prompt}')