User.create!([{
  email: "admin@admin.com",
  password: "password",
  role: "admin",
  gender: 'female',
  has_profile: true
},
{
  email: "daltonglass@gmail.com",
  password: "password",
  role: "dentist",
  gender: 'male',
},
{
  email: "ashleymorris@hotmail.com",
  password: "password",
  role: "dentist",
  gender: 'female',
},
{
  email: "carlabrown@rocketmail.com",
  password: "password",
  role: "dentist",
  gender: 'female',
},
{
  email: "kreugerpaul@gmail.com",
  password: "password",
  role: "staff",
  gender: 'male',
},
{
  email: "susanafrica@gmail.com",
  password: "password",
  role: "dentist",
  gender: 'female',
}
])

Profile.create!([{
  user_id: 2,
  first_name: 'Dalton',
  middle_name: 'T',
  last_name: 'Glass',
  date_of_birth: Date.parse("15/06/1995"),
  gender: 'male',
  mobile: '09457423469',
  address: 'La Paz, Makati City, Manila'
  },
  {
  user_id: 3,
  first_name: 'Ashley',
  middle_name: 'R',
  last_name: 'Morris',
  date_of_birth: Date.parse("22/03/1997"),
  gender: 'female',
  mobile: '09187504336',
  address: 'San Juan, Laguna, Manila'
},
{
  user_id: 4,
  first_name: 'Carla',
  middle_name: 'P',
  last_name: 'Brown',
  date_of_birth: Date.parse("07/12/1987"),
  gender: 'female',
  mobile: '09173247988',
  address: 'New Boulevard, Quezon City, Manila'
},
{
  user_id: 5,
  first_name: 'Kreuger',
  middle_name: 'D',
  last_name: 'Paul',
  date_of_birth: Date.parse("02/02/1999"),
  gender: 'male',
  mobile: '09194746282',
  address: 'Talon Singko, Las Pinas, Manila'
},
{
  user_id: 6,
  first_name: 'Susan',
  middle_name: 'V',
  last_name: 'Africa',
  date_of_birth: Date.parse("28/09/1993"),
  gender: 'female',
  mobile: '09202754413',
  address: 'Ayala Bay, Makati, Manila'
}
])

PatientRecord.create!([{
  full_name: 'Chris Hamilton',
  gender: 'male',
  date_of_birth: Date.parse("28/09/1993"),
  mobile: '09364578462',
  email: 'chris@hamilton.com',
  address: 'Queens Road, Sta. Ana, Manila'
},
{
  full_name: 'Will Rocks',
  gender: 'male',
  date_of_birth: Date.parse("16/07/1996"),
  mobile: '09147851213',
  email: 'will@rocks.com',
  address: 'Boardwalk, China Town, Manila'
},
{
  full_name: 'Catherine Bloom',
  gender: 'female',
  date_of_birth: Date.parse("09/04/1992"),
  mobile: '09175524816',
  email: 'bloom@gmail.com',
  address: 'Kings Extension, Quezon City, Manila'
},
{
  full_name: 'Warner Brother',
  gender: 'male',
  date_of_birth: Date.parse("22/04/1995"),
  mobile: '09165421879',
  email: 'warnerbros@gmail.com',
  address: 'Bluementrit, Ayala Avenue, Manila'
},
{
  full_name: 'Katy Holmes',
  gender: 'female',
  date_of_birth: Date.parse("02/01/1987"),
  mobile: '09159407117',
  email: 'kateholmes@rocketmail.com',
  address: 'Bluementrit, Ayala Avenue, Manila'
},
{
  full_name: 'Dana Richter',
  gender: 'female',
  date_of_birth: Date.parse("13/05/1992"),
  mobile: '09147896625',
  email: 'danarich@hotmail.com',
  address: 'Creeper Alley, Bagumbayan, Manila'
},
])

DentalRecord.create!([{
  services: ['tooth-extraction'],
  tooth: ['UR1'],
  branch: 'marcos-alvarez',
  patient_record_id: 1,
  user_id: 2,
  full_name: 'Chris Hamilton'
},
{
  services: ['basic-cleaning'],
  tooth: ['all'],
  branch: 'marcos-alvarez',
  patient_record_id: 1,
  user_id: 2,
  full_name: 'Chris Hamilton'
},
{
  services: ['teeth-whitening', 'teeth-filling'],
  tooth: ['all', 'UR5'],
  branch: 'marcos-alvarez',
  patient_record_id: 1,
  user_id: 2,
  full_name: 'Chris Hamilton'
},
{
  services: ['basic-cleaning'],
  tooth: ['all'],
  branch: 'marcos-alvarez',
  patient_record_id: 2,
  user_id: 3,
  full_name: 'Will Rocks'
},
{
  services: ['tooth-extraction'],
  tooth: ['UR5'],
  branch: 'marcos-alvarez',
  patient_record_id: 2,
  user_id: 3,
  full_name: 'Will Rocks'
},
{
  services: ['teeth-whitening'],
  tooth: ['all'],
  branch: 'marcos-alvarez',
  patient_record_id: 3,
  user_id: 4,
  full_name: 'Catherine Bloom'
},
{
  services: ['teeth-filling'],
  tooth: ['BL4', 'BL6'],
  branch: 'marcos-alvarez',
  patient_record_id: 3,
  user_id: 4,
  full_name: 'Catherine Bloom'
},
{
  services: ['teeth-whitening'],
  tooth: ['all'],
  branch: 'marcos-alvarez',
  patient_record_id: 4,
  user_id: 6,
  full_name: 'Warner Brother'
},
{
  services: ['root-canal'],
  tooth: ['UL7'],
  branch: 'marcos-alvarez',
  patient_record_id: 4,
  user_id: 6,
  full_name: 'Warner Brother'
},
{
  services: ['molar x-ray'],
  tooth: ['all'],
  branch: 'marcos-alvarez',
  patient_record_id: 5,
  user_id: 2,
  full_name: 'Katy Holmes'
},
{
  services: ['root canal'],
  tooth: ['BR6'],
  branch: 'marcos-alvarez',
  patient_record_id: 6,
  user_id: 3,
  full_name: 'Dana Richter'
},
])

Transaction.create!([{
  services: ['tooth-extraction'],
  status: 'full',
  branch: 'marcos-alvarez',
  amount: 500,
  remaining: 0,
  payment_type: 'cash',
  patient_record_id: 1,
  user_id: 2,
  full_name: 'Chris Hamilton'
},
{
  services: ['basic-cleaning'],
  status: 'full',
  branch: 'marcos-alvarez',
  amount: 1000,
  remaining: 0,
  payment_type: 'cash',
  patient_record_id: 1,
  user_id: 2,
  full_name: 'Chris Hamilton'
},
{
  services: ['teeth-whitening', 'teeth-filling'],
  status: 'full',
  branch: 'marcos-alvarez',
  amount: 3000,
  remaining: 0,
  payment_type: 'card',
  patient_record_id: 1,
  user_id: 2,
  full_name: 'Chris Hamilton'
},
{
  services: ['basic-cleaning'],
  status: 'full',
  branch: 'marcos-alvarez',
  amount: 1000,
  remaining: 0,
  payment_type: 'online',
  patient_record_id: 2,
  user_id: 3,
  full_name: 'Will Rocks'
},
{
  services: ['teeth-whitening'],
  status: 'partial',
  branch: 'marcos-alvarez',
  amount: 1200,
  remaining: 800,
  payment_type: 'cash',
  patient_record_id: 2,
  user_id: 3,
  full_name: 'Will Rocks'
},
{
  services: ['teeth-whitening'],
  status: 'full',
  branch: 'marcos-alvarez',
  amount: 1000,
  remaining: 0,
  payment_type: 'cash',
  patient_record_id: 3,
  user_id: 4,
  full_name: 'Catherine Bloom'
},
{
  services: ['teeth-filling'],
  status: 'partial',
  branch: 'marcos-alvarez',
  amount: 500,
  remaining: 500,
  payment_type: 'cash',
  patient_record_id: 3,
  user_id: 4,
  full_name: 'Catherine Bloom'
},
{
  services: ['teeth-whitening'],
  status: 'full',
  branch: 'marcos-alvarez',
  amount: 1000,
  remaining: 0,
  payment_type: 'online',
  patient_record_id: 4,
  user_id: 6,
  full_name: 'Warner Brother'
},
{
  services: ['root-canal'],
  status: 'full',
  branch: 'marcos-alvarez',
  amount: 5000,
  remaining: 0,
  payment_type: 'card',
  patient_record_id: 4,
  user_id: 6,
  full_name: 'Warner Brother'
},
{
  services: ['molar x-ray'],
  status: 'partial',
  branch: 'marcos-alvarez',
  amount: 6000,
  remaining: 6000,
  payment_type: 'cash',
  patient_record_id: 5,
  user_id: 2,
  full_name: 'Katy Holmes'
},
{
  services: ['root-canal'],
  status: 'full',
  branch: 'marcos-alvarez',
  amount: 5000,
  remaining: 0,
  payment_type: 'online',
  patient_record_id: 5,
  user_id: 3,
  full_name: 'Dana Richter'
},
])

Service.create([{
  name: 'tooth extraction'
},
{
  name: 'teeth whitening'
},
{
  name: 'tooth filling'
},
{
  name: 'root canal'
},
{
  name: 'molar x-ray'
},
{
  name: 'basic cleaning'
},
{
  name: 'brace'
},
{
  name: 'dentures'
},
])