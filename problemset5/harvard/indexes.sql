CREATE INDEX "search_courses_by_department"
ON "courses"("department");

CREATE INDEX "search_courses_by_title"
ON "courses"("title");

CREATE INDEX "search_courses_by_dep_num_sem"
ON "courses"("department", "number", "semester");

CREATE INDEX "serach_enrollments_by_student_id_course_id"
ON "enrollments"("student_id", "course_id");

CREATE INDEX "serach_enrollments_course_id"
ON "enrollments"("student_id", "course_id");

CREATE INDEX "serach_satisfies_by_course_id"
ON "satisfies"("course_id");

CREATE INDEX "serach_satisfies_by_requirement_id"
ON "satisfies"("requirements_id");
