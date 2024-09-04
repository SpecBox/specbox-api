class Home::Index < ApiAction
  get "/" do
    json({message: "SpecBox a.k.a. WebSpecimanager API"})
  end
end
