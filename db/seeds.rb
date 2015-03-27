#  create a relation > CourseTrack.create(course_id: 1, track_id: 1, order:2)

# Track.last.courses && Course.last.tracks

# get the order > CourseTrack.where(course_id: 1, track_id: 2).order