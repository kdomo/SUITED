package suited.com.dto;

public class SurveyDTO {
   private int seq_survey;
   private String name;
   private String gender;
   private int age;
   private String uncomfort1;
   private String uncomfort2;
   private String uncomfort3;
   private int height;
   private int weight;
   private String exercise;
   private String activity;
   private String eating_habits;
   private String favorite_food;
   private String family_disease;
   private String health_checkup;
   private String supplements;
   private String sources;
   private String email;
   private int bmi;
   
   public SurveyDTO() {}
   public SurveyDTO(int seq_survey, String name, String gender, int age, String uncomfort1, String uncomfort2,
         String uncomfort3, int height, int weight, String exercise, String activity, String eating_habits,
         String favorite_food, String family_disease, String health_checkup, String supplements, String sources,
         String email, int bmi) {
      super();
      this.seq_survey = seq_survey;
      this.name = name;
      this.gender = gender;
      this.age = age;
      this.uncomfort1 = uncomfort1;
      this.uncomfort2 = uncomfort2;
      this.uncomfort3 = uncomfort3;
      this.height = height;
      this.weight = weight;
      this.exercise = exercise;
      this.activity = activity;
      this.eating_habits = eating_habits;
      this.favorite_food = favorite_food;
      this.family_disease = family_disease;
      this.health_checkup = health_checkup;
      this.supplements = supplements;
      this.sources = sources;
      this.email = email;
      this.bmi = bmi;
   }
   
   public int getSeq_survey() {
      return seq_survey;
   }
   public void setSeq_survey(int seq_survey) {
      this.seq_survey = seq_survey;
   }
   public String getName() {
      return name;
   }
   public void setName(String name) {
      this.name = name;
   }
   public String getGender() {
      return gender;
   }
   public void setGender(String gender) {
      this.gender = gender;
   }
   public int getAge() {
      return age;
   }
   public void setAge(int age) {
      this.age = age;
   }
   public String getUncomfort1() {
      return uncomfort1;
   }
   public void setUncomfort1(String uncomfort1) {
      this.uncomfort1 = uncomfort1;
   }
   public String getUncomfort2() {
      return uncomfort2;
   }
   public void setUncomfort2(String uncomfort2) {
      this.uncomfort2 = uncomfort2;
   }
   public String getUncomfort3() {
      return uncomfort3;
   }
   public void setUncomfort3(String uncomfort3) {
      this.uncomfort3 = uncomfort3;
   }
   public int getHeight() {
      return height;
   }
   public void setHeight(int height) {
      this.height = height;
   }
   public int getWeight() {
      return weight;
   }
   public void setWeight(int weight) {
      this.weight = weight;
   }
   public String getExercise() {
      return exercise;
   }
   public void setExercise(String exercise) {
      this.exercise = exercise;
   }
   public String getActivity() {
      return activity;
   }
   public void setActivity(String activity) {
      this.activity = activity;
   }
   public String getEating_habits() {
      return eating_habits;
   }
   public void setEating_habits(String eating_habits) {
      this.eating_habits = eating_habits;
   }
   public String getFavorite_food() {
      return favorite_food;
   }
   public void setFavorite_food(String favorite_food) {
      this.favorite_food = favorite_food;
   }
   public String getFamily_disease() {
      return family_disease;
   }
   public void setFamily_disease(String family_disease) {
      this.family_disease = family_disease;
   }
   public String getHealth_checkup() {
      return health_checkup;
   }
   public void setHealth_checkup(String health_checkup) {
      this.health_checkup = health_checkup;
   }
   public String getSupplements() {
      return supplements;
   }
   public void setSupplements(String supplements) {
      this.supplements = supplements;
   }
   public String getSources() {
      return sources;
   }
   public void setSources(String sources) {
      this.sources = sources;
   }
   public String getEmail() {
      return email;
   }
   public void setEmail(String email) {
      this.email = email;
   }
   public int getBMI() {
      return bmi;
   }
   public void setBMI(int bmi) {
      this.bmi = bmi;
   }
}