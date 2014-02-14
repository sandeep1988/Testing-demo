angular.module('Demo12').factory('postData', ['$http', ($http) ->

  postData =
    data:
      posts: {title: 'Loading', author: '' ,contents: ''}
    isLoaded: false


  postData.createPost = (newPost) ->
    # Client-side data validation
    if newPost.newPostTitle == '' or newPost.newPostAuthor == '' or newPost.newPostContents == ''
      alert('Neither the Title nor the Body are allowed to be left blank.')
      return false

    # Create data object to POST
    data =
      new_post:
        title: newPost.newPostTitle
        author: newPost.newPostAuthor
        contents: newPost.newPostContents

    # Do POST request to /posts.json
    $http.post('./posts.json', data).success( (data) ->

      # Add new post to array of posts
      postData.data.posts.push(data)
      console.log('Successfully created post.')

    ).error( ->
      console.error('Failed to create new post.')
    )

    return true


  postData.loadPosts = (deferred) ->
    if !postData.isLoaded
      $http.get('./posts.json').success( (data) ->
        postData.data.posts = data
        postData.isLoaded = true
        console.log('Successfully loaded posts.')
        if deferred
          deferred.resolve()
      ).error( ->
        console.error('Failed to load posts.')
        if deferred
          deferred.reject('Failed to load posts.')
      )
    else
      if deferred
        deferred.resolve()
    

  return postData

])
