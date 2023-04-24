<template>
  <ul>
    <li v-for="message in messages">
      <div>{{ message.role }}</div>
      <div>{{ message.content }}</div>
    </li>
  </ul>
  <form @submit.prevent="onSubmit">
    <div class="mt-2">
      <textarea v-model="content" rows="4" class="block w-full rounded-md border-0 py-1.5 px-2 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6" />
    </div>
    <div class="mt-2 flex justify-end">
      <button type="submit" class="inline-flex items-center rounded-md bg-indigo-600 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600">Post</button>
    </div>
  </form>
</template>

<script setup>
const {API_SERVER_URL} = useRuntimeConfig();
const { data: chat } = await useFetch(`${API_SERVER_URL}/chats`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({chat: {ai_model: 'gpt-3.5-turbo-0301'}})
  });
const content = ref('');
const messages = ref([]);
const processing = ref(false);
const onSubmit = async (event) => {
  if (processing.value) {
    return;
  }
  processing.value = true;
  
  messages.value.push({
    role: 'user',
    content: content.value
  });

  const messageContent = content.value;
  content.value = '';

  const { data: message } = await useFetch(`${API_SERVER_URL}/chats/${chat.value.id}/completion`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({message: {content: messageContent}})
  });

  processing.value = false;
  messages.value.push(message.value);
};
</script>