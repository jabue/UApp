(function(window, undefined) {
  var dictionary = {
    "81e102ac-8589-4319-81fa-056f9a10f4e1": "Notification",
    "5e4934ef-dd4e-4197-bb79-885bc4e622e5": "personal home page",
    "de8ef008-5d80-4aa5-af13-c7bff7b7c9a6": "Activities",
    "c83ea9db-1ca6-41ea-93d0-2a48805588a6": "Table Home-Slide Menu",
    "8804b7d5-2ab1-49d5-bc19-5f143006e394": "Manually input timetable",
    "dbd83e23-76c6-46e9-89c5-4254578d5990": "General Setting",
    "6c559c13-7580-4d60-8e6e-c550095def29": "School Select",
    "81af9c32-5a1e-477c-9337-af01e9169bf5": "Hashtag Sample",
    "a625b276-366c-4e8c-a45c-9216fc0e7d75": "Message",
    "fcd174b5-39d9-43af-84cc-feae11ab42f2": "Add a course to your timetable",
    "d4dac288-92f6-4828-9fa3-86f28f7b9ca5": "Table Home",
    "06215896-0d39-430b-b086-52fbf345eb51": "Login",
    "c45fd643-5972-4077-a510-96a3ff3ac0d2": "Signup",
    "c70b1ca8-e861-4e46-80bd-513186f38bf0": "Edit Profile",
    "3b689c2b-32f1-431f-b2c6-36ffc343fa3b": "school news",
    "80c91f7f-2b6c-4078-932d-be2382636b6d": "Setting",
    "f434639f-57a6-451b-8a1c-052efa7ce510": "Setting-Slide Menu",
    "7abd2717-0351-4623-a2e9-47ac1e6dde06": "My Photos",
    "5c900952-17b0-4b6b-b242-4e3b9b5771bc": "Activities - side menu",
    "9a955c8d-6939-450c-9ac1-12deac2e08ff": "personal home page-Slide Menu",
    "e7a61ddd-1c9e-4960-85dd-2372024c160f": "Camera",
    "dcc895e3-f294-45a7-bfa7-a8d77a38677b": "school news - side menu",
    "8981d557-479d-46a4-8e1a-c580f3a894ee": "Home",
    "77e48ece-a7ac-4b03-ac23-cf1dfe8482cf": "QR Code",
    "f39803f7-df02-4169-93eb-7547fb8c961a": "Template 1"
  };

  var uriRE = /^(\/#)?(screens|templates|masters)\/(.*)(\.html)?/;
  window.lookUpURL = function(fragment) {
    var matches = uriRE.exec(fragment || "") || [],
        folder = matches[2] || "",
        canvas = matches[3] || "",
        name, url;
    if(dictionary.hasOwnProperty(canvas)) { /* search by name */
      url = folder + "/" + canvas;
    }
    return url;
  };

  window.lookUpName = function(fragment) {
    var matches = uriRE.exec(fragment || "") || [],
        folder = matches[2] || "",
        canvas = matches[3] || "",
        name, canvasName;
    if(dictionary.hasOwnProperty(canvas)) { /* search by name */
      canvasName = dictionary[canvas];
    }
    return canvasName;
  };
})(window);