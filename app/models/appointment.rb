class Appointment < ApplicationRecord
  belongs_to :user

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :schedule_date, presence: true
  validates :schedule_time, presence: true
  validates :branch, presence: true
  validates :services, presence: true

  def self.set_appointment(appointment_params, id)
    date = appointment_params[:schedule_date]
    time = appointment_params[:schedule_time]
    branch = appointment_params[:branch]

    if Appointment.schedule_available?(date, time, branch)
      Appointment.create!(
        :user_id => id,
        :branch => branch,
        :schedule_date => date,
        :schedule_time => time,
        :first_name => appointment_params[:first_name],
        :last_name => appointment_params[:last_name],
        :mobile => appointment_params[:mobile],
        :services => appointment_params[:services],
        :dentist_id => id
      )
    end
  end

  def self.schedule_available?(date, time, branch)
    appointments = Appointment.all.where(
      :schedule_date => date,
      :schedule_time => time,
      :branch => branch
    )

    return true if appointments.blank?
  end

  def self.get_events
    data = Calendly::Client.show_events
    filtered_data = data[:data]['collection']
    events = []

    filtered_data.each do |data|
      event = {}
      event[:name] = data['name']
      event[:start] = Time.parse(data['start_time'].in_time_zone('Asia/Singapore').to_s).strftime('%H:%M %p')
      event[:end] = Time.parse(data['end_time'].in_time_zone('Asia/Singapore').to_s).strftime('%H:%M %p')
      event[:start_date] = DateTime.parse(data['start_time']).in_time_zone('Asia/Singapore')
      event[:end_date] = DateTime.parse(data['end_time']).in_time_zone('Asia/Singapore')
      event[:event_uri] = data['uri'].split('/').last

      events << event
    end

    return events
  end

  def self.get_participants
    events = Appointment.get_events
    participants = []

    events.each do |event|
      invitees = []
      uri = event[:event_uri]

      response = Calendly::Client.show_participants(uri)
      filtered_data = response[:data]['collection']

      filtered_data.each do |data|
        invitee = {}
        invitee[:name] = data['name']
        invitee[:email] = data['email']
        invitee[:participant_uri] = data['uri'].split('/').last

        invitees << invitee
      end

      participants << invitees
    end
    return participants
  end

  def self.get_appointments
    events = Appointment.get_events
    participants = Appointment.get_participants

    appointments = []

    events.each_with_index do |event, i|
      appointment = {}
      appointment['event'] = event[:name]
      appointment['start'] = event[:start]
      appointment['end'] = event[:end]
      appointment['start_date'] = event[:start_date]
      appointment['end_date'] = event[:end_date]
      appointment['participants'] = []

      participants[i].each do |participant|
        patient = {}
        patient['name'] = participant[:name]
        patient['email'] = participant[:email]

        appointment['participants'] << patient
      end

      appointments << appointment
    end

    return appointments
  end

  def self.appointments_today
    now = Time.now
    appointments = Appointment.get_appointments

    today = []
    appointments.each do |appointment|
      if appointment['date'].to_date == Date.today
        today << appointment
      end
    end
    
    return today
  end

  def self.calendar_events
    appointments = Appointment.get_appointments
    events = []

    appointments.each do |appointment|
      event = {}
      event['title'] = appointment['start'] + ' Appointment'
      event['start'] = appointment['start_date']
      event['end'] = appointment['end_date']
      
      events << event
    end

    return events
  end

  def dentist
    User.find(dentist_id)
  end
end