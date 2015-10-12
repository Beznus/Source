class Email < ActiveRecord::Base
  belongs_to :product
  belongs_to :company
  
  def associate_company!
    c = Company.where(:company_token => self.recipient.split('@', 2).first.split("_").second).first
    if c
      self.update_attributes(:company_id => c.id)
    end
  end

  def associate_resource!
    in_recipient = false
    Company.find_by(id: self.company_id).resources.each do |resource|
      if self.recipient.split('@', 2).first.split("_").third.to_s == (resource.resource_token)
        if resource.active
          self.update_attributes(:resource_id => resource.id)
          in_recipient = true
        end
      end
    end

    if !in_recipient
      Company.find_by(id: self.company_id).resources.order("LENGTH(resource_token) DESC").each do |resource|
        if contains?(resource.resource_token)
          return self.update_attributes(:resource_id => resource.id)
        end
      end
    end
  end

  def contains?(string)
    if (self.recipient) && (self.recipient.include? string)
      return true
    elsif (self.sender) && (self.sender.include? string)
      return true
    elsif (self.subject) && (self.subject.include? string)
      return true
    elsif (self.body_html) && (self.body_html.include? string)
      return true
    elsif (self.body_plain) && (self.body_plain.include? string)
      return true
    end

    false
  end

  def self.search(search, resource)
    if !search.blank? && resource.blank?
      where('subject LIKE ?', "%#{search}%")
    elsif !resource.blank? && search.blank?
      where('resource_id= ?', resource)
    elsif !search.blank? && !resource.blank?
      where('subject LIKE ? AND resource_id = ?', "%#{search}%", resource)
    else
      all
    end
  end


  def blob
    result = " "
    result += self.recipient if !(self.recipient.nil?)
    result += " " + self.from if !(self.from.nil?)
    result += " " + self.body_plain if !(self.body_plain.nil?)
    result += " " + self.sender if !(self.sender.nil?)
    result += " " + self.subject if !(self.sender.nil?)
    result += " " + self.body_html if !(self.sender.nil?)
    result
  end
end
