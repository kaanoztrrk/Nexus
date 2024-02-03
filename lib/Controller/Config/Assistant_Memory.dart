class Memory {
  UserMemory userMemory;
  ConversationMemory conversationMemory;

  Memory({required String userName, Map<String, dynamic>? userData})
      : userMemory = UserMemory(userName: userName, initialData: userData),
        conversationMemory = ConversationMemory();

  void setUserMemoryData(String key, dynamic value) {
    userMemory.setUserData(key, value);
  }

  dynamic getUserMemoryData(String key) {
    return userMemory.getUserData(key);
  }

  void setConversationMemoryData(String key, dynamic value) {
    conversationMemory.setData(key, value);
  }

  dynamic getConversationMemoryData(String key) {
    return conversationMemory.getData(key);
  }
}

class UserMemory {
  String userName;
  Map<String, dynamic> data;

  UserMemory({required this.userName, Map<String, dynamic>? initialData})
      : data = initialData ?? {};

  void setUserData(String key, dynamic value) {
    data[key] = value;
  }

  dynamic getUserData(String key) {
    return data[key];
  }
}

class ConversationMemory {
  Map<String, dynamic> data;

  ConversationMemory({Map<String, dynamic>? initialData})
      : data = initialData ?? {};

  void setData(String key, dynamic value) {
    data[key] = value;
  }

  dynamic getData(String key) {
    return data[key];
  }
}
